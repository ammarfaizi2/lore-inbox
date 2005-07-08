Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbVGHWS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbVGHWS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbVGHWPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:15:37 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:27371 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262920AbVGHWMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:12:46 -0400
In-Reply-To: <courier.42CEC422.00001C6C@courier.cs.helsinki.fi>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Cc: Andrew Morton <akpm@osdl.org>, bfields@fieldses.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
Subject: Re: share/private/slave a subtree - define vs enum
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFD3952820.9408A09B-ON88257038.00761D1C-88257038.0079FBC4@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 8 Jul 2005 15:12:30 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_06092005|June 09, 2005) at
 07/08/2005 18:12:31,
	Serialize complete at 07/08/2005 18:12:31
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't see how the following is tortured: 
>
>enum {
>       PNODE_MEMBER_VFS  = 0x01,
>       PNODE_SLAVE_VFS   = 0x02
>}; 

Only because it's using a facility that's supposed to be for enumerated 
types for something that isn't.  If it were a true enumerated type, the 
codes for the enumerations (0x01, 0x02) would be quite arbitrary, whereas 
here they must fundamentally be integers whose pure binary cipher has 
exactly one 1 bit (because, as I understand it, these are used as bitmasks 
somewhere).

I can see that this paradigm has practical advantages over using macros 
(or a middle ground - integer constants), but only as a byproduct of what 
the construct is really for.

