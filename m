Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130200AbRCBA5M>; Thu, 1 Mar 2001 19:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130206AbRCBA5D>; Thu, 1 Mar 2001 19:57:03 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:50936 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S130200AbRCBA4s>; Thu, 1 Mar 2001 19:56:48 -0500
Date: Thu, 1 Mar 2001 16:55:30 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>
cc: linux-kernel@vger.kernel.org
Subject: Re: negative mod use count
In-Reply-To: <200102281958.UAA13226@falcon.etf.bg.ac.yu>
Message-ID: <Pine.LNX.4.21.0103011653340.8542-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Boris Dragovic wrote:
> what does negative module use count mean?

That means that there's a bug in someone's driver.
For some reason, the function to decrement the module use is called more
than once when a controlling process releases use of a module. 

This will prevent you from being able to 'rmmod' or 'modprobe -r' it; a
"Device or resource busy" error or similar will result IIRC. 

Submit a bug to the driver maintainer.

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

