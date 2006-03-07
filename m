Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWCGBpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWCGBpp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWCGBpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:45:45 -0500
Received: from kanga.kvack.org ([66.96.29.28]:24007 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932592AbWCGBpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:45:44 -0500
Date: Mon, 6 Mar 2006 20:40:26 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Status of AIO
Message-ID: <20060307014026.GV20768@kvack.org>
References: <20060306062402.GA25284@localdomain> <20060306211854.GM20768@kvack.org> <20060307013049.GA19775@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307013049.GA19775@localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 03:30:50AM +0200, Dan Aloni wrote:
> Well, I've written a small test app to see if it works with network
> sockets and apparently it did for that small test case (connect() 
> with aio_read(), loop with aio_error(), and aio_return()). I thought 
> perhaps the glibc implementation was running behind the scene, so I've 
> checked to see if it a thread was created in the background and I 
> there wasn't any thread. 

Unfortunately, it will block in io_submit when it shouldn't.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
