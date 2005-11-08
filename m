Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVKHXhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVKHXhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVKHXhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:37:20 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:53961 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030265AbVKHXhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:37:18 -0500
Date: Tue, 8 Nov 2005 17:36:58 -0600
To: Neil Brown <neilb@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@austin.ibm.com,
       linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs 
Message-ID: <20051108233657.GB19593@austin.ibm.com>
References: <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com> <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com> <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain> <17263.64754.79733.651186@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17263.64754.79733.651186@cse.unsw.edu.au>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 12:18:42PM +1100, Neil Brown was heard to remark:
> 
> Another reason  for not using typedefs is that if you do, and you want
> to refer to the structure in some other include file, you have to
> #include the include file that devices the structure.
> If you don't use typedefs, you can just say:
> 
>    struct foo;
> 
> and the compiler will happily wait for the complete definition later
> (providing it doesn't need the size in the meanwhile). 

Yes, this is the "forward declaration" problem I was refering to. 
Its unavoidable if structs have circular references to each other.

However, I've learned, by experience, several things by trying to
eliminate such forward declarations (and the related #include hell):

-- Its really, really hard, and right in the middle, you think,
   "gosh this is a stupid idea, why am I bothering?"

-- When you get done, you think: "wow this new code structure
   is so insanely better than the old code! The guy who wrote
   the old code should be hung from a yardarm as an example!"

So having a mechanism that prevents coders from declaring 
"struct foo" whenever they feel like it can be a good thing.
Of course, your milage may vary.

--linas
