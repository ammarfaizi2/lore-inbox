Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269350AbRHGTQ3>; Tue, 7 Aug 2001 15:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269351AbRHGTQI>; Tue, 7 Aug 2001 15:16:08 -0400
Received: from nef.ens.fr ([129.199.96.32]:20492 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S269350AbRHGTP4>;
	Tue, 7 Aug 2001 15:15:56 -0400
Date: Tue, 7 Aug 2001 21:15:44 +0200
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: torrey.hoffman@myrio.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: encrypted swap
Message-ID: <20010807211544.A51912@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C9A8@mail0.myrio.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <D52B19A7284D32459CF20D579C4B0C0211C9A8@mail0.myrio.com> you write:
> Now that laptop is stolen at an airport.

This is indeed the target of choice for a disk-encrypting software.
But you need to encipher three zones:
-- the swap space, as you stated
-- the whole filesystem itself, because you do not know if your favorite
word-processor won't create temporary files (well, maybe you can
limit yourself to /home and /tmp)
-- the zone that the machine uses for the "suspend to disk" option ;
and I guess that one will be tricky. A potential solution, which covers
also the "suspend to memory" option, is to encipher all data in physical
memory when there is a suspend operation. Only the kernel, including
the code wich asks for the deciphering key, remains clear.

About performance: modern cryptosystem on modern cpus run at about
2 cycles per bit of data.


	--Thomas Pornin
