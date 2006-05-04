Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWEDTOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWEDTOR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWEDTOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:14:17 -0400
Received: from silver.veritas.com ([143.127.12.111]:33303 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030296AbWEDTOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:14:17 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,89,1146466800"; 
   d="scan'208"; a="37878161:sNHT23927172"
Date: Thu, 4 May 2006 20:14:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: dtor_core@ameritech.net
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
In-Reply-To: <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605041954490.20879@blonde.wat.veritas.com>
References: <20060504024404.GA17818@redhat.com> <20060504071736.GB5359@ucw.cz>
  <445A18D8.1030502@mbligh.org> <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 May 2006 19:14:16.0095 (UTC) FILETIME=[EF91F2F0:01C66FAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2006, Dmitry Torokhov wrote:
> > > On Wed 03-05-06 22:44:04, Dave Jones wrote:
> > >
> > > >There are two messages in the input layer that seem to be
> > > >triggerable very easily, and they confuse end-users to no end.
> > > >"too many keys pressed? Should I press less keys?"
> 
> Also I don't understand what people have against this message, it's at
> KERN_DEBUG level after all.

I often type at the text console; and I like to see KERN_DEBUG messages;
but I do NOT like to see kernel messages telling me I've mistyped - they
don't hurt my pride, but they do mess up my screen.

If I hit a wrong key, it's normal for that wrong key to be echoed, not a
kernel message saying "Are you sure you didn't want to hit another key?".
If I don't hit a key hard enough, it's normal for that key not to be
echoed.  So why, if I happen to hit a combination of keys by mistake,
do I get that wretched "too many keys pressed" message?  The appropriate
response is for what is accepted to be echoed, and that is all.

I keep #ifdef ATKBD_DEBUG around both the messages Dave highlighted
(but I forget when it was that I used to get the second one); the -mm
tree has had the "too many keys" message commented out for many months.

Hugh
