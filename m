Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272773AbTHFFBR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272801AbTHFFBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:01:16 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:33811
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S272773AbTHFFBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:01:15 -0400
Subject: Re: [PATCH] autofs4 doesn't expire
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: maneesh@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Dick Streefland <dick.streefland@xs4all.nl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030806050003.GB1298@in.ibm.com>
References: <4b0c.3f302ca5.93873@altium.nl>
	 <20030805164904.36b5d2cc.akpm@osdl.org> <20030806042853.GA1298@in.ibm.com>
	 <1060144454.18625.5.camel@ixodes.goop.org>
	 <20030806050003.GB1298@in.ibm.com>
Content-Type: text/plain
Message-Id: <1060146067.18687.9.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 05 Aug 2003 22:01:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-05 at 22:00, Maneesh Soni wrote:
> +	if (vfs) {
> +		if (is_vfsmnt_tree_busy(vfs))
> +			ret--;
> +		/* just to reduce ref count taken in lookup_mnt
> +	 	 * cannot call mntput() here
> +	 	 */
> +		atomic_dec(&vfs->mnt_count);

I wonder if we shouldn't make this atomic_dec_and_test with a BUG, just
for paranoia's sake.

	J

