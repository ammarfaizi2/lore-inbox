Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVKWPzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVKWPzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVKWPzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:55:54 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:35554 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1750760AbVKWPzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:55:53 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17284.37107.573883.328659@gargle.gargle.HOWL>
Date: Wed, 23 Nov 2005 18:55:31 +0300
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use enum to declare errno values
Newsgroups: gmane.linux.kernel
In-Reply-To: <20051123154423.32867.qmail@web25802.mail.ukl.yahoo.com>
References: <1132758910.7268.32.camel@localhost.localdomain>
	<20051123154423.32867.qmail@web25802.mail.ukl.yahoo.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moreau francis writes:

[...]

 > 
 > I guess we won't use enumeration because it needs to many changes...Each
 > function that returns a errno value should have their prototype changed like
 > this:
 > 
 >     int foo(void)
 >     {
 >             int retval;
 >             [...]
 >             return retval;
 >     }
 > 
 > should be changed into
 > 
 >     enum errnoval foo(void)
 >     {
 >             enum errnoval retval;
 >             [...]
 >             return retval;
 >     }

No it shouldn't. Following is a perfectly legal thing to do in C:

enum side {
        LEFT,
        RIGHT
};

int foo(int x)
{
        if (x & 0x1)
                return LEFT;
        else
                return RIGHT;
}

This is not C++ fortunately.

Nikita.
