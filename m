Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUHHMbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUHHMbI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 08:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbUHHMbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 08:31:08 -0400
Received: from server02.akkaya.de ([213.168.83.203]:53271 "EHLO
	server02.akkaya.de") by vger.kernel.org with ESMTP id S265288AbUHHMbF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 08:31:05 -0400
From: Juergen Pabel <jpabel@akkaya.de>
To: Eric Lammerts <eric@lammerts.org>
Subject: Re: [PATCH] Masking kernel commandline parameters (2.6.7)
Date: Sun, 8 Aug 2004 14:30:49 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408080413.29905.jpabel@akkaya.de> <Pine.LNX.4.58.0408072238570.22657@vivaldi.madbase.net>
In-Reply-To: <Pine.LNX.4.58.0408072238570.22657@vivaldi.madbase.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408081430.59840.jpabel@akkaya.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> That would make that ugly kernel patch pointless, wouldn't it? Then
> why bother with it?

Also, what aspects of it do you consider ugly? -I didn't see any better way of 
implementing this feature. No, I don't like the fact that I am mangling the 
command_line and saved_command_line arrays directly, but I wanted to reuse as 
many constructs of the kernel as possible - and that means doing just that. 

The only other aspect I see that isn't real nice is the re-setting of the 
quotation mark, which was replaced with a \0 by the parse_args function - 
this requires access to a negative array index... Also note that I placed 
special emphasis on not providing opportunity for buffer overflows or other 
boundary issues.

Please elaborate on your thoughts, if there is a better way of implementing 
this, I'll surely adapt my work.

jp

ps: in case you're referring to the feature itself, what would be a more 
sensible way of passing sensitive data to the kernel? -I didn't see any other 
way.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBFhz5z6J7R+QJGuwRAqZDAJ46UglAXcpeuX/NjZSz5LSTVvhXqQCfbyBx
5tbm+DsRfhZudqWEPXHWIPA=
=Tv5d
-----END PGP SIGNATURE-----
