Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311782AbSCUNdT>; Thu, 21 Mar 2002 08:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311888AbSCUNdK>; Thu, 21 Mar 2002 08:33:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:11745 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311782AbSCUNdA>; Thu, 21 Mar 2002 08:33:00 -0500
Subject: Re: [PATCH] 2.4.19-pre3 - readv/writev should return EINVAL for
	count=0
From: Paul Larson <plars@austin.ibm.com>
To: Alexander.Riesen@synopsys.com
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020321083408.C1350@riesen-pc.gr05.synopsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 21 Mar 2002 07:28:50 -0600
Message-Id: <1016717331.2202.108.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-21 at 01:34, Alex Riesen wrote:
> I would disagree. According to the spec "The iovcnt argument is valid
> if greater than 0 and less than or equal to {IOV_MAX}, as defined in
> <limits.h>" (http://www.opengroup.org/onlinepubs/007904975/).
> The behaviour you want to achieve is described as optional, besides
> there is programs depending on the old behaviour (of my own at least :).
> It's very handy to skip extra zero-parameter check...
> -alex
^-This is the one I was referring to.  Is there any reason for it to not
be in compliance with this?
"The iovcnt argument is valid if greater than 0 and less than or equal to {IOV_MAX}, as defined in
 <limits.h>" (http://www.opengroup.org/onlinepubs/007904975/)

Sorry, I just noticed that there was a previous thread here in which a
patch was submitted by balbir_soni@yahoo.com.  I think the same person
who started it might have been the same person that pointed out that one
of our LTP testcases was passing when it shouldn't be and brought it to
my attention.  It doesn't look like that thread got resolved though.

Paul Larson

