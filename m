Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283269AbRLIJ2a>; Sun, 9 Dec 2001 04:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283270AbRLIJ2W>; Sun, 9 Dec 2001 04:28:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34053 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283269AbRLIJ2J>; Sun, 9 Dec 2001 04:28:09 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [OT] fputc vs putc Re: horrible disk thorughput on itanium
Date: 9 Dec 2001 01:27:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9uvaqn$u4s$1@cesium.transmeta.com>
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de> <20011207.130316.39156883.davem@redhat.com> <20011208201907.A937@zero> <m1d71pw51p.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1d71pw51p.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> fputc is a function putc is a macro because the overhead of a function call
> in writing a character has always been a problem...
> 

putc() is frequently defined as

#define putc(__C)   fputc((__C), stdout)

... or some equivalent; I think the best way to say it's that it's a
shorthand.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
