Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVIFPwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVIFPwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 11:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVIFPwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 11:52:15 -0400
Received: from smtpout.mac.com ([17.250.248.70]:62912 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750734AbVIFPwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 11:52:14 -0400
In-Reply-To: <BAY106-F34D910C37C07A9F8D18173ABA70@phx.gbl>
References: <BAY106-F34D910C37C07A9F8D18173ABA70@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D10533AF-9FD4-4231-B9DE-030FB12983A7@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Modifying Cryptography code
Date: Tue, 6 Sep 2005 11:51:53 -0400
To: Alaa Dalghan <alaadalghan@hotmail.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 6, 2005, at 08:38:48, Alaa Dalghan wrote:
> What I am looking for is the portion of the C code in the kernel where
> the Decryption function is called to decrypt a received packet. When I
> find this statement, maybe i can make it conditionnal such as:  If the
> destination is me then Decrypt  else DO NOT!

You can't make this work.  First of all, the other WinXP clients would
be completely unable to decrypt your packets, because they don't have
the right key.  Secondly, the kernel cannot know what the destination
is until *after* it has decrypted the packet, because the real target
address is encrypted along with the rest of the data for security.  If
your OpenSwan box is too slow, get a faster OpenSwan box, don't try to
break the encryption to make it faster.  You cannot remove enough
encryption features to get the required extra speed without disabling
the encryption entirely.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E
W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+++) 5  
X R?
tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


