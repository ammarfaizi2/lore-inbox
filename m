Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265451AbSKACBW>; Thu, 31 Oct 2002 21:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265481AbSKACBV>; Thu, 31 Oct 2002 21:01:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23057 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265451AbSKACBQ>;
	Thu, 31 Oct 2002 21:01:16 -0500
Message-ID: <3DC1E1AE.4070706@pobox.com>
Date: Thu, 31 Oct 2002 21:06:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Matt D. Robinson" <yakker@aparity.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
References: <Pine.LNX.4.44.0210311732110.23393-100000@nakedeye.aparity.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt D. Robinson wrote:

>On Thu, 31 Oct 2002, Jeff Garzik wrote:
>|>Linus Torvalds wrote:
>|>[yes, I realize the LKCD merge debate is over, bear with me :)]
>
>For Linus, it is.
>
>|>That said, I used to be an LKCD cheerleader until a couple people made 
>|>some good points to me:  it is not nearly low-level enough to truly be 
>|>of use in crash situations.  netdump can work if your interrupts are 
>|>hosed/screaming, and various mid-layers are dying.  For LKCD to be of 
>|>any use, it needs to _skip_ the block layer and talk directly to 
>|>low-level drivers.
>
>Just to clarify, LKCD is NOT block based dumping, OR net based
>dumping, or anything.  It's an infrastructure for dumping that
>lets you, the user, the distributor, the customer, whatever,
>make the decision for what's right for you.  Yes, we provide
>disk based dumping now, and are including the net dump code
>very soon, as well as some of these other smaller dump methods.
>
>Has ANYONE other than Christoph and Stephen H. done a full review of
>the LKCD patch set before commenting?  Or are people just making
>this stuff up as they go along?  A ton of things have changed
>over the past year just because people complained about only doing
>disk dumping.  And then to hear this ...
>  
>
You are confusing review with perspective.  I've read 
http://lkcd.sourceforge.net/download/latest/ before, and just checked it 
again tonight before posting.

My view is:  LKCD becomes useful to merge when the average user can do 
"safe" disk dumps.  netdumps are better for corporate customers, but for 
average users, disk dumps are _the_ method which is easiest, most 
accessible, and thus most helpful to kernel hackers debugging their 
problems.  LKCD has a dump block dev driver, but it's not even close to 
being low-level enough to be "safe".

Re-read my other post(s) -- I have said repeatedly that LKCD's 
infrastructure is decent.  But it's completely pointless to merge a 
decent infrastructure unless the users are up to snuff.  It's much 
smarter to keep the infrastructure out of the kernel until the low-level 
dump drivers are hammered out and stable, because that gives you more 
freedom to change the API.


>|>So, I think the stock kernel does need some form of disk dumping, 
>|>regardless of any presence/absence of netdump.  But LKCD isn't
>|>there yet...
>
>Please read the patches and decide again.  If you want the latest
>net dump patch, let me know.
>  
>

I have.  Nothing has changed.  Stable, polling, low-level disk dumps are 
not in the LKCD patches.

IMO, net dump is what corporate customers and network admins want.  And 
overall, net dumps are probably easier and much safer than disk dumps, 
from an implementor's perspective.  However, disk dumps are what the 
average kernel hacker will find most useful, because it is the easiest 
for end users, and thus will generate a higher number of quality bug 
reports.

    Jeff



