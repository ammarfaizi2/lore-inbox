Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277381AbRJENlM>; Fri, 5 Oct 2001 09:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRJENkx>; Fri, 5 Oct 2001 09:40:53 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:37895 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S277381AbRJENkc>; Fri, 5 Oct 2001 09:40:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: philippe.aubry@mangoosta.fr
Subject: Re: [POT] Linux SAN?
Date: Fri, 5 Oct 2001 09:42:27 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.21.0110032019480.12116-100000@dozer.dreamhost.com> <E15oxYi-00015G-00@schizo.psychosis.com> <01100422312200.01464@homer>
In-Reply-To: <01100422312200.01464@homer>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15pVCy-0006zo-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 October 2001 22:31, you wrote:

> For the HBA ( fibre channel adapter ) i use the module in the kernel CPQFC
> is for a specific compaq HBA, but you can use use QLOGIC module or EMULEX (
> but the EMULEX driver is not under GPL and you don't have source and it's
> really convinient for the correction on the driver ) with support for FC.

FYI to all interested in playing with Fibre Channel:
The FC HBA driver put out by Qlogic works well but does a silly thing; it 
enumerates devices from 0, instead of by the actually loop ID. This makes 
it impossible to spec absolute paths to the device, as everything will
shift when devices are moved on the FC loop.

This one liner patch to qla2x00.c fixes this problem, by enumerating
by loop id.

ftp://ftp.psychosis.com/linux/fibrechannel/qla_fixid.c

-- 
The time is now 22:19 (Totalitarian)  -  http://www.ccops.org/clock.html
