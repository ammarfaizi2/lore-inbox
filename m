Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSIBG2n>; Mon, 2 Sep 2002 02:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSIBG2m>; Mon, 2 Sep 2002 02:28:42 -0400
Received: from holomorphy.com ([66.224.33.161]:36248 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317402AbSIBG2m>;
	Mon, 2 Sep 2002 02:28:42 -0400
Date: Sun, 1 Sep 2002 23:27:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Robert Love <rml@tech9.net>, Rusty Russell <rusty@rustcorp.com.au>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
Message-ID: <20020902062738.GP888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, Robert Love <rml@tech9.net>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, akpm@zip.com.au
References: <20020902003318.7CB682C092@lists.samba.org> <1030945918.939.3143.camel@phantasy> <20020902060257.GO888@holomorphy.com> <15731.1019.581339.120099@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <15731.1019.581339.120099@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday September 1, wli@holomorphy.com wrote:
>> Seconded. Throw the whole frog in the blender, please, not just half.

On Mon, Sep 02, 2002 at 04:23:55PM +1000, Neil Brown wrote:
> The struct in question is a handle on an element of a list, or the
> head of a list, but it is not a list itself.  A list is a number of
> stuctures each of which contain (inherit from?)  the particular
> structure.  So calling it "struct list" would be wrong, because it
> isn't a list, only part of one.
> Maybe "struct list_element" or "struct list_entry" would be OK.  But
> I'm happy with "struct list_head", because the thing is, at least
> sometimes, the head of a list.

Why bother? It's obvious what it is, and the debate weighs more in terms
of bickering over what the most descriptive possible term is than all the
supposed fluff in terms of diffsize. Just give it an obvious name that
doesn't require so many extraneous characters to type and rest assured
in that this of all things is too obvious to mistake for anything else.
This much time and effort isn't useful to spend explaining or messing with
something as trivial as lists. Let names be short and kill the typedef.

Cheers,
Bill
