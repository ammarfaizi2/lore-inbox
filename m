Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293513AbSCUHfB>; Thu, 21 Mar 2002 02:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293515AbSCUHew>; Thu, 21 Mar 2002 02:34:52 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:31637 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S293513AbSCUHeg>; Thu, 21 Mar 2002 02:34:36 -0500
Date: Thu, 21 Mar 2002 08:34:08 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Paul Larson <plars@austin.ibm.com>
Subject: Re: [PATCH] 2.4.19-pre3 - readv/writev should return EINVAL for count=0
Message-ID: <20020321083408.C1350@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
In-Reply-To: <1016650428.2202.98.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would disagree. According to the spec "The iovcnt argument is valid
if greater than 0 and less than or equal to {IOV_MAX}, as defined in
<limits.h>" (http://www.opengroup.org/onlinepubs/007904975/).
The behaviour you want to achieve is described as optional, besides
there is programs depending on the old behaviour (of my own at least :).
It's very handy to skip extra zero-parameter check...
-alex

On Wed, Mar 20, 2002 at 12:53:47PM -0600, Paul Larson wrote:
> This is a minor patch against 2.4.19-pre3 for readv/writev to have it
> return EINVAL if count=0 is passed to it.  According to the man page and
> also the specifications for readv/writev, this is the correct behaviour.
> 
