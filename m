Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290812AbSBFVSD>; Wed, 6 Feb 2002 16:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290819AbSBFVRy>; Wed, 6 Feb 2002 16:17:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40456 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290812AbSBFVRi>; Wed, 6 Feb 2002 16:17:38 -0500
Message-ID: <3C619D69.6090605@zytor.com>
Date: Wed, 06 Feb 2002 13:17:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <p73ofj2lpdg.fsf@oldwotan.suse.de> <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua> <20020206101231.X21624@devserv.devel.redhat.com> <a3s34p$51o$1@cesium.transmeta.com> <20020206161511.D21624@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:

>>>
>>x86-64, interestingly, retains vestigial meaning of the %fs and %gs
>>registers (but no others) to use as a base pointer for this reason
>>alone.
> 
> Well, on x86-64 this is purely x86-64 ABI designers decision, they could
> pick one of %r8 - %r15 and use that as thread pointer instead (and were
> recommended to do so).
> 


Wasting an architectural register is still bloody expensive, even if 1
among 16 is less than 1 among 8.  They'll be using %gs as thread pointer
in userspace and CPU pointer in kernel space.

	-hpa


