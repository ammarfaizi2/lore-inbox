Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272362AbRHYAeq>; Fri, 24 Aug 2001 20:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272365AbRHYAeh>; Fri, 24 Aug 2001 20:34:37 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39357 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272362AbRHYAeS>;
	Fri, 24 Aug 2001 20:34:18 -0400
Date: Fri, 24 Aug 2001 20:34:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Brad Chapman <kakadu_croc@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010825002528.2202.qmail@web10903.mail.yahoo.com>
Message-ID: <Pine.GSO.4.21.0108242028270.19796-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Aug 2001, Brad Chapman wrote:

> > > 
> > > 	What do you think, sir?
> > 
> > 	Use different inline functions for signed and unsigned.
> > Explicitly.
> 
> 	OK. That sounds reasonable, but do we want to do another forced
> change, or do we want to hide it? That seems to be the root of the problem:
> keeping the same API but making it work _right_.

Existing API is wrong.  "Hiding" is precisely what's wrong here - we
use the same name for two subtly different functions.

