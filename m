Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272345AbRHXX7G>; Fri, 24 Aug 2001 19:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272347AbRHXX65>; Fri, 24 Aug 2001 19:58:57 -0400
Received: from web10908.mail.yahoo.com ([216.136.131.44]:33296 "HELO
	web10908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272345AbRHXX6m>; Fri, 24 Aug 2001 19:58:42 -0400
Message-ID: <20010824235858.59972.qmail@web10908.mail.yahoo.com>
Date: Fri, 24 Aug 2001 16:58:58 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: Ben LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108241919080.1398-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Ben LaHaise <bcrl@redhat.com> wrote:
> On Fri, 24 Aug 2001, Brad Chapman wrote:
> 
> > 	This way, some hackers can use the two-arg min()/max() inside an #ifdef block,
> > other hackers can use the three-arg min()/max() inside an #ifdef block,
> > and people who don't care can select either.
> 
> Have you no taste?  Use of #ifdef's should be minimised as much as
> possible.  For this kind of construct, the spurious preprocessor usage
> just makes me want to vomit.
> 
> 		-ben

Mr. LaHaise,

	Eeek! Sorry. That was just a preliminary. As I see it, there are
several ways to wire this up:

	- make everyone use the new macros (some people are thinking :P)

	- make everyone use #ifdef blocks with a config option (you think it's :P)

	- make min()/max() typeof() wrappers for a switch-style stack of comparison 
	  functions which work on the various types, i.e:
	
	  __u8 minimum = min(one, two) -> __u8 minimum = __u8_min(one, two)

	  (this may be too complex and is probably :P)

	- make min()/max() inline functions, cast things to void, and use memcmp()
	  (this might almost be reasonable, but is probably also :P)

	- stay with the old-style macros (:P, :P, :P)

	What do you think, sir?

Brad
	


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
