Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbUBXDKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 22:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbUBXDKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 22:10:31 -0500
Received: from terminus.zytor.com ([63.209.29.3]:54701 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262140AbUBXDKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 22:10:30 -0500
Message-ID: <403AC099.90208@zytor.com>
Date: Mon, 23 Feb 2004 19:10:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@greatcn.org>
CC: Philippe Elie <phil.el@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: Does Flushing the Queue after PG REALLY a Necessity?
References: <c16rdh$gtk$1@terminus.zytor.com> <4039D599.7060001@greatcn.org> <20040223151815.GA403@zaniah> <403AB897.8070002@greatcn.org>
In-Reply-To: <403AB897.8070002@greatcn.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
 >
> The problem is there's two jumps in the kernel. Intel's manual only asks 
> for "Execute a near JMP instruction".
> 

A far JMP is definitely sufficient, and serves to normalize EIP as well.

I have uploaded a patch which also preinitializes the GDT, which may 
make the VISWS code a bit less of a special case.

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/earlymem-4.diff

> If no any reason for the two jumps, the code should be fixed to remains 
> only ONE near jump.

Why are you so obsessed with minimality?  The performance of this code 
matters not one bit.

	-hpa
