Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269067AbRH0VWw>; Mon, 27 Aug 2001 17:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269081AbRH0VWn>; Mon, 27 Aug 2001 17:22:43 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:52491 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269067AbRH0VW3>; Mon, 27 Aug 2001 17:22:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 23:29:13 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <Pine.LNX.4.33L.0108271213370.5646-100000@imladris.rielhome.cone ctiva> <516649838.998944465@[169.254.198.40]>
In-Reply-To: <516649838.998944465@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827212237Z16070-32384+719@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 09:34 pm, Alex Bligh - linux-kernel wrote:
> As another optimization, we may need to think of pages used
> by multiple streams. Think, for instance, of 'make -j' and
> header files, or many users ftp'ing down the same file.
> Just because one gcc process has read past
> a block in a header file, I submit that we are less keen to
> drop it if it is in the readahead chain for another.

This is supposed to be handled by putting the page on the active list and 
aging it up, i.e., the current behaviour.

--
Daniel
