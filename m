Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbUDUOV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUDUOV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbUDUOV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:21:58 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:10710 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S262974AbUDUOVz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:21:55 -0400
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: arjanv@redhat.com, Andrew Morton <akpm@osdl.org>,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>, b-gruber@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
	<Pine.GSO.4.58.0404191124220.21825@stekt37>
	<20040419015221.07a214b8.akpm@osdl.org>
	<xb77jwci86o.fsf@savona.informatik.uni-freiburg.de>
	<1082372020.4691.9.camel@laptop.fenrus.com>
	<16518.20890.380763.581386@cse.unsw.edu.au>
	<xb71xmhfu9j.fsf@savona.informatik.uni-freiburg.de>
	<16518.27472.760406.691633@cse.unsw.edu.au>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 21 Apr 2004 16:21:53 +0200
In-Reply-To: <16518.27472.760406.691633@cse.unsw.edu.au>
Message-ID: <xb7oeple7i6.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Neil" == Neil Brown <neilb@cse.unsw.edu.au> writes:

    >> BTW, how did you hack the /dev/psaux?

    Neil> It's not suitable for inclusion, but with this patch, I get
    Neil> two modules, psdev and psmouse.  I load psdev and /dev/psaux
    Neil> is raw.  I load psmouse and /dev/psaux is normal 2.6
    Neil> behaviour.

    [patch snipped]


I see.  Basically, we're both (re)inventing the same thing.  :)

Now, it  is clear that there is  a need for direct  psaux port access.
It's useful for 2 reasons:

1) Compatibility with 2.4, 2.2, 2.0  kernels, so that programs need no
   modification and work as before.  This provides an easier migration
   path for those who want to upgrad to 2.6 for whatever reasons.

2) To  enable  using "strange",  not  yet  supported hardwares,  whose
   *mature* software  drivers are already available for 2.4, 2.2, 2.0,
   etc.  Not every writer of  those software drivers are interested in
   rewriting their programs in kernel space.



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

