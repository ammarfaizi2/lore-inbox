Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266226AbUFPJEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266226AbUFPJEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 05:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266225AbUFPJEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 05:04:37 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:51386 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266224AbUFPJEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 05:04:35 -0400
Message-ID: <40D00D1F.8070109@yahoo.com.au>
Date: Wed, 16 Jun 2004 19:04:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: David Howells <dhowells@redhat.com>, Nuno Monteiro <nuno@itsari.org>,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [2.4] build error with latest BK
References: <40CFB2A1.8070104@yahoo.com.au>	<20040615164848.GA8276@hobbes.itsari.int>	<3473.1087374022@redhat.com>	<40D00828.8020303@yahoo.com.au> <16592.3188.448186.438659@alkaid.it.uu.se>
In-Reply-To: <16592.3188.448186.438659@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Nick Piggin writes:
>  > David Howells wrote:
>  > >>-		put_task_struct(tsk);
>  > >>+		task_unlock(tsk);
>  > > 
>  > > 
>  > > Ummm... that doesn't look right.
>  > > 
>  > > 
>  > >>-	get_task_struct(tsk);
>  > > 
>  > > 
>  > > This is necessary to stop someone deallocating the task structure, can the
>  > > task structure be deallocated whilst locked?
>  > > 
>  > 
>  > Ooh maybe it can. Should that be a read_lock of the tasklist lock then?
> 
> For 2.4 kernels, use get_task_struct() and free_task_struct() [not put]
> for locking and unlocking a task.
> 

Sorry I'm an idiot. I'm sure Marcelo has already fixed it.
Just simply replace put_task_struct with free_task_struct.
