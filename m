Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272350AbRH3RTo>; Thu, 30 Aug 2001 13:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272352AbRH3RTe>; Thu, 30 Aug 2001 13:19:34 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:40453 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272350AbRH3RTZ>; Thu, 30 Aug 2001 13:19:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: ptb@it.uc3m.es
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Date: Thu, 30 Aug 2001 19:26:19 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200108301703.TAA05549@nbd.it.uc3m.es>
In-Reply-To: <200108301703.TAA05549@nbd.it.uc3m.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010830171934Z16012-32384+1116@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 30, 2001 07:03 pm, Peter T. Breuer wrote:
> "Daniel Phillips wrote:"
> > More than anything, it shows that education is needed, not macro 
patch-ups.
> > We have exactly the same issues with < and >, should we introduce 
> > three-argument macros to replace them?
> 
> # define le(t,a,b) ({ t _a = a; t _b = b;  min(t,_a,_b) == _a ; })
> # define ge(t,a,b) ({ t _a = a; t _b = b;  min(t,_a,_b) == _b ; })

Oh, you are one sick puppy.

For completeness:

# define lt(t,a,b) ({ t _a = a; t _b = b;  min(t,_a,_b) != _b ; })
# define gt(t,a,b) ({ t _a = a; t _b = b;  min(t,_a,_b) != _a ; })

--
Daniel

