Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUIMUwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUIMUwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUIMUwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:52:23 -0400
Received: from linares.terra.com.br ([200.154.55.228]:41142 "EHLO
	linares.terra.com.br") by vger.kernel.org with ESMTP
	id S268950AbUIMUvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:51:48 -0400
Message-ID: <414607C7.4000801@terra.com.br>
Date: Mon, 13 Sep 2004 17:49:11 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040902
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: Neil Horman <nhorman@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] close race condition in shared memory mapping/unmapping
References: <4146041F.2040106@redhat.com>
In-Reply-To: <4146041F.2040106@redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Neil,

Neil Horman wrote:
> +	down(&shm_ids.sem);
>  	shp = shm_lock(shmid);
>  	if(shp == NULL) {
> +		shm_unlock(shp);
> +		up(&shm_ids.sem);
>  		err = -EINVAL;
>  		goto out;
>  	}

	Trying to unlock a NULL pointer?

	Cheers,

Felipe
