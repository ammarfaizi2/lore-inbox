Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268872AbRG0QDi>; Fri, 27 Jul 2001 12:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268878AbRG0QD3>; Fri, 27 Jul 2001 12:03:29 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:26119 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S268872AbRG0QDP>; Fri, 27 Jul 2001 12:03:15 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1
In-Reply-To: <9C117960438@vcnet.vc.cvut.cz>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 27 Jul 2001 18:03:17 +0200
In-Reply-To: <9C117960438@vcnet.vc.cvut.cz> ("Petr Vandrovec"'s message of "Thu, 26 Jul 2001 20:28:32 MET-1")
Message-ID: <tg8zhafjga.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:

> Just adding '-finline-limit=150' fixes all of them

This is not a fix, this is a workaround which is suitable for some
specific GCC release(s).  The optimization decisions surrounding
inlining are likely to change again, so this will break almost
certainly in the future.

At least one GCC frontend has got a pragma called Always_Inline.  This
seems the way to go.  For the C frontend, you would use a function
attribute, of course.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
