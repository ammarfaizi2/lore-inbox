Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264865AbTGBWo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbTGBWo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:44:28 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:53401 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264865AbTGBWoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:44:25 -0400
Date: Wed, 2 Jul 2003 15:53:30 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Yet another SDET hang (73-mm3) ... yawn
Message-Id: <20030702155330.7d879299.akpm@digeo.com>
In-Reply-To: <570860000.1057184743@flay>
References: <570860000.1057184743@flay>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2003 22:58:50.0405 (UTC) FILETIME=[8083BD50:01C340ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> 2.5.73-mm3 + feral + highpte (ext2)
> 
> Seems to be all wedged up on io_schedule. Not sure if it was
> highpte that caused this or not, but I'd done one run on ext2
> and one on ext3 without it, and they worked fine.

highpte, or highpmd?

I assume the latter.  But either way, it would be an odd correlation.

It looks more like the block layer or device driver blew a fuse.  The usual
deal: make it repeatable, then try `elevator=deadline', then try a
different driver..

Oh, and write OpenSDET while you're at it.  grr.

