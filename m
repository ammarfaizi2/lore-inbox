Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263596AbUEPN2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUEPN2U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 09:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUEPN2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 09:28:20 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:33412 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263596AbUEPN2S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 09:28:18 -0400
From: Jan De Luyck <lkml@kcore.org>
To: "P. Christeas" <p_christ@hol.gr>
Subject: Re: [2.6.6] Synaptics driver is 'jumpy'
Date: Sun, 16 May 2004 15:28:39 +0200
User-Agent: KMail/1.6.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200405161427.44859.p_christ@hol.gr>
In-Reply-To: <200405161427.44859.p_christ@hol.gr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405161528.43329.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 16 May 2004 13:27, P. Christeas wrote:
> Under normal load this shouldn't happen. It could only have to do with
> interrupts from PS/2 port.

Unfortunately, it happens all the time, even if the CPU load == 0.00. I don't 
have any other PS/2 devices (since I don't have a PS/2 port ;p) but I do use 
a USB mouse - but this is totally unrelated to this problem.

> Try running the touchpad in relative mode, with 'options psmouse
> proto=exps' at /etc/modprobe.conf, which disables the Synaptics (i.e.
> absolute mode).

Well... This causes X to bomb out with not finding any Synaptics device - 
which If i understand the driver correctly is quite correct at this point.

The fact is, it worked _perfectly_ under 2.6.5 with the standard mode. No 
problems whatsoever. Something must have changed (but I'm too unfamiliar with 
kernel code) that causes some sort of a delay in the processing of the input 
queue of the touchpad. 

I've upgraded the X driver, but that changes nothing.

Jan

- -- 
"For the man who has everything... Penicillin."
 -- F. Borquin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAp2yJUQQOfidJUwQRAvhEAJ9AlsLKIyPb1lP+6lql6E8YhEieOgCcDSQZ
giKmwZyuYUkkR3YiAfGfYso=
=CBBE
-----END PGP SIGNATURE-----
