Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbTFBP2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTFBP2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:28:48 -0400
Received: from mail5.iserv.net ([204.177.184.155]:13469 "EHLO mail5.iserv.net")
	by vger.kernel.org with ESMTP id S262459AbTFBP2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:28:47 -0400
Message-ID: <3EDB7053.3040707@didntduck.org>
Date: Mon, 02 Jun 2003 11:42:11 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuart MacDonald <stuartm@connecttech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Redundant code?
References: <00e301c3291c$22d4f270$294b82ce@stuartm>
In-Reply-To: <00e301c3291c$22d4f270$294b82ce@stuartm>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart MacDonald wrote:
> Seems to me the following is redundant code, since get_fd_set also
> memsets the fds.res_* bitmaps.
> 
> ..Stu
> 
> --- linux-2.5.70/fs/select.c	2003-05-26 21:00:21.000000000 -0400
> +++ linux-2.5.70-new/fs/select.c	2003-06-02 11:40:24.000000000 -0400
> @@ -344,9 +344,6 @@
>  	    (ret = get_fd_set(n, outp, fds.out)) ||
>  	    (ret = get_fd_set(n, exp, fds.ex)))
>  		goto out;
> -	zero_fd_set(n, fds.res_in);
> -	zero_fd_set(n, fds.res_out);
> -	zero_fd_set(n, fds.res_ex);
>  
>  	ret = do_select(n, &fds, &timeout);
>  
> 

fds.in != fds.res_in

--
				Brian Gerst

