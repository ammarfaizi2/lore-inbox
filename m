Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSBOCRZ>; Thu, 14 Feb 2002 21:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSBOCRP>; Thu, 14 Feb 2002 21:17:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6916 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286339AbSBOCRK>; Thu, 14 Feb 2002 21:17:10 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: user-space <-> kernel-space
Date: 14 Feb 2002 18:14:38 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a4hque$e0s$1@cesium.transmeta.com>
In-Reply-To: <02021411333501.00959@henrique.cyclades.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <02021411333501.00959@henrique.cyclades.com.br>
By author:    Henrique Gobbi <henrique@cyclades.com>
In newsgroup: linux.dev.kernel
>
> Hello !!!
> 
> I am trying to develop a line analyzer to my multi-serial card but I am not 
> seeing a good solution to send data from the driver to the application in the 
> user-space.
> 
> Inittialy, I thought in use a char device, but all my minors are beeing used 
> and I don't wanna to use another major. 
> 
> I'd like to know two things:
> 1 - Is there any way to use more than 256 minors under a major

Not until we get a larger dev_t.

> 2 - Is there a simple way to send data from the kernel-space to the 
> user-space?

A character device node.

Use a minor from the miscdevice series.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
