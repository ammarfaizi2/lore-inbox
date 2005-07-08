Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVGHQdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVGHQdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVGHQdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:33:31 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:46282 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262707AbVGHQdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:33:23 -0400
In-Reply-To: <Pine.LNX.4.61.0507081527040.3743@scrub.home>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, bfields@fieldses.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Pekka J Enberg <penberg@cs.helsinki.fi>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Subject: Re: share/private/slave a subtree - define vs enum
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFF7ECFC50.4EDB3D93-ON88257038.0059F048-88257038.005AEAF4@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 8 Jul 2005 09:33:08 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_06092005|June 09, 2005) at
 07/08/2005 12:33:20,
	Serialize complete at 07/08/2005 12:33:20
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't aware anyone preferred defines to enums for declaring enumerated 
data types.  The practical advantages of enums are slight, but as far as I 
know, the practical advantages of defines are zero.  Isn't the only 
argument for defines, "that's what I'm used to."?

Two advantages of the enum declaration that haven't been mentioned yet, 
that help me significantly:

- if you have a typo in a define, it can be really hard to interpret the 
compiler error messages.  The same typo in an enum gets a pointed error 
message referring to the line that has the typo.

- Gcc warns you if a switch statement doesn't handle every case.  I often 
add an enumeration and Gcc lets me know where I forgot to consider it.

The macro language is one the most hated parts of the C language; it makes 
sense to try to avoid it as a general rule.

