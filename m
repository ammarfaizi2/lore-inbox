Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758344AbWK0QBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758344AbWK0QBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758347AbWK0QBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:01:18 -0500
Received: from nz-out-0102.google.com ([64.233.162.201]:6499 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1758343AbWK0QBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:01:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I6k+ddmzSd5hA76ag8d0R+a2q04LO5rU6y1fFzdMAZsPdHuavlJuLz14gHqG3IH87/h39cLDlKe9EA5SyVdD/s2aC0GEkefXDb4z7ZhRdVXzxX5ApzlzMTEKNspDo7alEPqVen3IZLJgfbCb3RvSvVnMGEwToPxxpEApE2RYbEg=
Message-ID: <9a8748490611270801g38417047ybcf4304bad9ad673@mail.gmail.com>
Date: Mon, 27 Nov 2006 17:01:16 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       stable@vger.kernel.org
Subject: Re: [PATCH] IDE: typo in ide-io.c leads to faulty assignment
In-Reply-To: <87k61h3pu2.fsf@denkblock.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <87k61h3pu2.fsf@denkblock.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/06, Elias Oltmanns <eo@nebensachen.de> wrote:
> Due to a typo in ide_start_power_step, the result of a function rather
> than its pointer is assigned to args->handler. The patch applies to
> 2.6.19-rc6 but the problem exists in the stable branch as well.
>

These two lines :

-		args->handler = task_no_data_intr;
+		args->handler = &task_no_data_intr;

do the same thing.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
