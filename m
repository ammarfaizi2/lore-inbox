Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318334AbSG3QQ5>; Tue, 30 Jul 2002 12:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318337AbSG3QQ5>; Tue, 30 Jul 2002 12:16:57 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:21695 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S318334AbSG3QQ5>; Tue, 30 Jul 2002 12:16:57 -0400
Message-ID: <39B5C4829263D411AA93009027AE9EBB13299549@fmsmsx35.fm.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: "'Mala Anand'" <manand@us.ibm.com>
Cc: Bill Hartner <Bill_Hartner@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>
Subject: RE: [Lse-tech] [RFC]  per cpu slab fix to reduce freemiss
Date: Tue, 30 Jul 2002 09:20:05 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mala Anand wrote:
> >Are you going to have some external structure to maintain the linked
> >list?  Or secretly enlarge the object to provide space for the link,
> >or some other way?
> No I am using the object(beginning space) to store the links. When
> allocated, I can initialize the space occupied by the link address.

You can't use the start of the object (or any other part) in this way,
you'll have no way to restore the value you overwrote.

Take a look at Jeff Bonwick's paper on slab allocators which explains
this a lot better than I can:

http://www.usenix.org/publications/library/proceedings/bos94/full_papers/bon
wick.a

-Tony
