Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVHDT50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVHDT50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVHDT5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:57:25 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:8151 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261416AbVHDT5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:57:25 -0400
Message-ID: <42F27290.2070002@nortel.com>
Date: Thu, 04 Aug 2005 13:54:56 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Roland Dreier <rolandd@cisco.com>, Arjan van de Ven <arjan@infradead.org>,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Move InfiniBand .h files
References: <52iryla9r5.fsf@cisco.com> <1123178038.3318.40.camel@laptopd505.fenrus.org> <52acjxa70j.fsf@cisco.com> <1123180717.3318.43.camel@laptopd505.fenrus.org> <52wtn18r7w.fsf@cisco.com> <20050804192229.GA26714@mars.ravnborg.org>
In-Reply-To: <20050804192229.GA26714@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Thu, Aug 04, 2005 at 11:57:55AM -0700, Roland Dreier wrote:

>>Sorry, I was too terse about the problem.  You're right, but typical
>>distros don't ship full kernel source in their "support kernel builds"
>>package.  And if I use an external build directory (ie "O=") then
>>the symlink just points to my external build directory, which doesn't
>>include the source to drivers/, just links to include/
> 
> 
> If the external module uses a Kbuild file as explained in
> Documentation/kbuild/makefiles.txt and then uses both O= and M=
> when compiling the module there is no issue.
> 
> With respect to moving the .h files - please do so.
> drivers/infiniband should only include header used in that same
> directory. Not header files potentially uased by fs/.

I think Roland was talking about the case where the running kernel was 
built with "O=", in which case the /lib/modules.../build symlink points 
to the build directory rather than the original source tree.

Does Kbuild handle this case properly?

Chris
