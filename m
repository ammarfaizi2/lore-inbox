Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267085AbTAFScl>; Mon, 6 Jan 2003 13:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbTAFScl>; Mon, 6 Jan 2003 13:32:41 -0500
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:32240 "EHLO
	mailout6-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S267085AbTAFScj> convert rfc822-to-8bit; Mon, 6 Jan 2003 13:32:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Stephen Evanchik <evanchsa@clarkson.edu>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Subject: Re: [PATCH 2.5.54] hermes: serialization fixes
Date: Mon, 6 Jan 2003 13:36:46 -0500
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200301031239.29226.evanchsa@clarkson.edu> <200301031256.41451.evanchsa@clarkson.edu> <878yxyqiri.fsf@lapper.ihatent.com>
In-Reply-To: <878yxyqiri.fsf@lapper.ihatent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301061336.46890.evanchsa@clarkson.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 January 2003 12:40, Alexander Hoogerhuis wrote:

|  There is something not quite right about this patch. I used have a ton
|  of errors in my logs, and this patch seemed to clear this out nicely.

I belive there were some serialization issues in that version of the driver.
Things have been rewritten substantially since the driver that was included
to 2.4.20. The 2.5.54 driver should be relatively unchanged with my patch
as I believe most of the serialization issues have been resolved. 

|  When I run with a patched driver now, I run for about 20 minutes with
|  various loads and sudenly the ksoftirqd_CPU0 process starts to hog my
|  CPU and not wanting to let go. As soon as I pull out the card, the
|  load returns to normal.

I noticed this too, but long after 20 minutes. After about 10 hours of continuous
download from a local mirror @ 250kb/sec things started to get interesting. As 
you mention, removing the card cleans things out.

|  Is there any way I can provide more details on what is happening?

There are a number of problems with the 2.4.20 driver and I recommend using
the latest from David Gibson's site: 

http://www.ozlabs.org/people/dgibson/dldwd

Incidently, it's what David recommends as well -- I've personally been using
the testing version with great success. There are still some issues though;
I'm pinning them down with the help from the comments David has provided me.

Most of the work in getting this driver working seems to have been done in the
newest versions -- it's just the little things now.

---
Stephen Evanchik

