Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293216AbSBWVlw>; Sat, 23 Feb 2002 16:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293222AbSBWVlm>; Sat, 23 Feb 2002 16:41:42 -0500
Received: from mail.interware.hu ([195.70.32.130]:34771 "EHLO
	mail.interware.hu") by vger.kernel.org with ESMTP
	id <S293219AbSBWVlb>; Sat, 23 Feb 2002 16:41:31 -0500
Date: Sat, 23 Feb 2002 22:41:20 +0100 (CET)
From: endre@interware.hu
To: "Teodor.Iacob@astral.kappa.ro" <Teodor.Iacob@astral.kappa.ro>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Problem? 802.1q kernel 2.4.18-rc1-rmap12f
In-Reply-To: <Pine.LNX.4.31.0202230003150.2719-100000@linux.kappa.ro>
Message-ID: <Pine.LNX.4.44.0202232239130.8602-100000@dusk.interware.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Feb 2002, Teodor Iacob wrote:

> > Did you patch the ethernet driver so that it supports the bigger
> > MTUs needed for VLAN support ? It's all described in the VLAN patch docs.
>
> Is there any drawback to use this patch? :
> In const char i82557_config_cmd[22] = {
> -       0x68, 0, 0x40, 0xf2, 0xBD,              /* 0xBD->0xFD=Force
> full-duplex */
> +       0x68, 0, 0x40, 0xfa, 0xBD,              /* 0xBD->0xFD=Force
> full-duplex */
>

AFAIK you have to change 2 values in this section: the second and third
occurences of 0xf2 to 0xfa.

endre

