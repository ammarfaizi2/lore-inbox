Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVHDTWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVHDTWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVHDTWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:22:17 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:34369 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262627AbVHDTWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:22:16 -0400
Date: Thu, 4 Aug 2005 21:22:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: Arjan van de Ven <arjan@infradead.org>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Move InfiniBand .h files
Message-ID: <20050804192229.GA26714@mars.ravnborg.org>
References: <52iryla9r5.fsf@cisco.com> <1123178038.3318.40.camel@laptopd505.fenrus.org> <52acjxa70j.fsf@cisco.com> <1123180717.3318.43.camel@laptopd505.fenrus.org> <52wtn18r7w.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52wtn18r7w.fsf@cisco.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 11:57:55AM -0700, Roland Dreier wrote:
>     Roland> Also, drivers/infiniband/include doesn't get put into the
>     Roland> /lib/modules/<ver>/build directory,
> 
>     Arjan> that is a symlink not a directory, and a symlink to the
>     Arjan> full source...
> 
> Sorry, I was too terse about the problem.  You're right, but typical
> distros don't ship full kernel source in their "support kernel builds"
> package.  And if I use an external build directory (ie "O=") then
> the symlink just points to my external build directory, which doesn't
> include the source to drivers/, just links to include/

If the external module uses a Kbuild file as explained in
Documentation/kbuild/makefiles.txt and then uses both O= and M=
when compiling the module there is no issue.

With respect to moving the .h files - please do so.
drivers/infiniband should only include header used in that same
directory. Not header files potentially uased by fs/.

	Sam
