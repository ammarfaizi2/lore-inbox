Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291510AbSBMKMw>; Wed, 13 Feb 2002 05:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291509AbSBMKMp>; Wed, 13 Feb 2002 05:12:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62470 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291492AbSBMKMb>; Wed, 13 Feb 2002 05:12:31 -0500
Subject: Re: AX25 Patches for 2.4.17 and above - have they been included yet
To: stephen@g6dzj.demon.co.uk
Date: Wed, 13 Feb 2002 10:26:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org
In-Reply-To: <E16awCH-000Hrq-0Y@anchor-post-34.mail.demon.net> from "Stephen Kitchener" at Feb 13, 2002 10:03:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16awc9-0004sY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been looking and searching the latest kernel pachecs and update for 
> the fixes that were issued some time ago, but I have yet to see them.

Thats because they were wrong..

> + *             Jeroen Vreeken  :       Add check for sk->dead in 
> sock_def_write_space
>   *
>   * To Fix:
>   *
> @@ -1146,7 +1147,7 @@
>         /* Do not wake up a writer until he can make "significant"
>          * progress.  --DaveM
>          */
> -       if((atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
> +       if(!sk->dead && (atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
>                 if (sk->sleep && waitqueue_active(sk->sleep))

See 2.4.18-ac which has a newer update for this.
