Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVILREL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVILREL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVILREL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:04:11 -0400
Received: from main.gmane.org ([80.91.229.2]:60893 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932100AbVILREK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:04:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Antonio Amorim <Antonio.Amorim@paipix.org>
Subject: Re: [PATCH] 2.6.13 =?utf-8?b?ZmxvY2tzX3JlbW92ZV9mbG9jaw==?= hits BUG();
Date: Mon, 12 Sep 2005 16:40:01 +0000 (UTC)
Message-ID: <loom.20050912T183812-156@post.gmane.org>
References: <20050902145049.9E6E633CDA@rekin5.o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.117.43.13 (Mozilla/5.0 (compatible; Konqueror/3.3; Linux 2.6.11; X11) KHTML/3.3.2 (like Gecko))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub W. Jozwicki <jakub007@...> writes: 
 
>  
> Because of incomplete conditional flocks_remove_flock runs into    
> BUG() which is below 'ifs'. This was visible with using unionfs.   
>  
> --- locks.c	2005-09-02 16:38:40.770509784 +0200      
> +++ locks-fixed.c	2005-09-02 16:37:22.000000000 +0200      
>  <at>  <at>  -1908,7 +1908,7  <at>  <at>       
>  
>  	while ((fl = *before) != NULL) {      
>  		if (fl->fl_file == filp) {      
> -			if (IS_FLOCK(fl)) {      
> +			if (IS_FLOCK(fl) || IS_POSIX(fl)) {      
>  				locks_delete_lock(before);      
>  				continue;      
>  			}      
>  
 
What was the UNIONFS version that you were able to compile with the 2.6.13 
kernel. Did it work ok after applying the patrch? 
 
All the best, 
Antonio Amorim 
 

