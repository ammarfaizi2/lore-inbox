Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbTDRRib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTDRRib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:38:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53515 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263162AbTDRRib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:38:31 -0400
Date: Fri, 18 Apr 2003 10:50:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: akpm@digeo.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct loop_info64
In-Reply-To: <UTC200304181719.h3IHJ1i03344.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0304181047190.2950-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Apr 2003 Andries.Brouwer@cwi.nl wrote:
> 
> I agree less with the statement that they must be u32 instead of int.
> My main reason is historical: the Unix interface is defined in terms
> of char/int/long.

Yes, but it sucks. Look at how _hard_ it has been to add standard sized 
types even just to user-mode C.

It so happens that "int" has been fairly stable at 32 bits for a long
time, and largely continues to be so. That's make it less painful than
most other things. "long" has certainly long since stopped being a good
type for doing any portable stuff. 

So while "char" and "int" have happened to not be painful, it's still
wrong to depend on types that aren't explicitly sized, because it _will_
break eventually.

		Linus

