Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264128AbRFMQvL>; Wed, 13 Jun 2001 12:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264131AbRFMQvB>; Wed, 13 Jun 2001 12:51:01 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:6388 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S264128AbRFMQu5>;
	Wed, 13 Jun 2001 12:50:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mark Mokryn <mark@sangate.com>
cc: Rafael Herrera <raffo@neuronet.pitt.edu>, linux-kernel@vger.kernel.org
Subject: Re: SMP module compilation on UP? 
In-Reply-To: Your message of "Wed, 13 Jun 2001 17:43:54 +0300."
             <3B277C2A.B2CC3FCF@sangate.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 02:50:35 +1000
Message-ID: <19041.992451035@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001 17:43:54 +0300, 
Mark Mokryn <mark@sangate.com> wrote:
>Is this the only way - to keep two separately configured kernel source
>trees? No way to do it via some flag?

With 2.4, yes.  You need a complete set of kernel source for every set
of config files you use because the object code is written to the
source directory.  With 2.5 you can have a single source tree and
multiple object trees, one for each config that you are working on.

In either case you must keep separate sets of objects for each config,
mixing objects from different configs in a single tree is a recipe for
disaster.

