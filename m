Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266497AbSKORPY>; Fri, 15 Nov 2002 12:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266491AbSKORPY>; Fri, 15 Nov 2002 12:15:24 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:1790 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266480AbSKORPW>;
	Fri, 15 Nov 2002 12:15:22 -0500
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
To: kniht@us.ibm.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-kernel-owner@vger.kernel.org, mailing-lists@digitaleric.net,
       "Martin J. Bligh" <mbligh@aracnet.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFF50CC956.56290AFD-ON85256C72.005E479D@pok.ibm.com>
From: "Khoa Huynh" <khoa@us.ibm.com>
Date: Fri, 15 Nov 2002 11:21:43 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 11/15/2002 12:21:44 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jon Tollefson wrote:
>> Right - that makes sense ... I'll let Jon figure out the best way
>> to acheive this inside bugzilla - Eric's suggestion of version would
>> be nicer, but require some significant mods to bugzilla, I think.
>> Failing that, your suggestion of a new product-type thing would be
>> pretty easy to implement.
>>
>> M.
>>
>>
>
>What if we create a top level category called Patches(or something) and
>have a components under that for each tree, patch set.  So anything
>thats not from Linus' tree could be put into one of these components.
>The natural owner for each of these components would be the maintainer
>of the named tree/patch.  Perhaps that is what you are suggesting above
>and I have misread it?

The problem we have here is that all "versions" share the same set of
components -- and therefore, the same set of component owners.  So if
we just create another version, say "2.5-ac", then we would not be able
to assign Alan Cox to the components belonging to this version because
there is only one set of components shared by all versions.

A way to get around this is to create 3-level component list (as opposed
to 2-level currently: category and components).  This 3-level component
list would go like this:

Product --> Category --> Component

whereas

Product = 2.5-linus, 2.5-ac, etc.
Category = same as currently
Component = same as currently

What this does is that each product (2.5-linus, 2.5-ac, etc) would have
its *own* set of categories and components.  This way we could assign all
categories and components under product 2.5-ac to Alan, and all categories
and components under 2.5-linus to other maintainers.

We could then delete "Version" from the bug reports as it no longer means
anything much.

Or we could use the name "version" for "product" in the scheme I described
above.

Khoa




