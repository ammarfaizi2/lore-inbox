Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSDQRMF>; Wed, 17 Apr 2002 13:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293132AbSDQRME>; Wed, 17 Apr 2002 13:12:04 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:64972 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S310749AbSDQRKl>; Wed, 17 Apr 2002 13:10:41 -0400
Date: Wed, 17 Apr 2002 18:09:26 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Martin Rode <martin.rode@programmfabrik.de>
Cc: Nikita Danilov <Nikita@Namesys.COM>, linux-kernel@vger.kernel.org
Subject: Re: Callbacks to userspace from VFS ?
Message-ID: <20020417180926.C2046@kushida.apsleyroad.org>
In-Reply-To: <1019053273.8655.109.camel@marge> <15549.34936.502136.339319@laputa.namesys.com> <1019054427.8745.114.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Rode wrote:
> I did not look deeper into F_NOTIFY, but if I only get a SIGNAL I don't
> know _what_ has happened (or better on what file something has
> happened). But to process the new / updated files I need the filename.
> If I only learn which directory was updated I still have to find out
> _which_ file is new or was changed.

If you use a real-time signal (number >= SIGRTMIN), then you can find
out which directory was affected.  Look for "siginfo" and SA_SIGINFO.

But you are right that it doesn't tell you which filename is new or was
changed.

-- Jamie
