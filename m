Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266220AbUFPIn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUFPIn1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 04:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUFPIn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 04:43:27 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:14505 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266220AbUFPInZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 04:43:25 -0400
Message-ID: <40D00828.8020303@yahoo.com.au>
Date: Wed, 16 Jun 2004 18:43:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Nuno Monteiro <nuno@itsari.org>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
Subject: Re: [2.4] build error with latest BK
References: <40CFB2A1.8070104@yahoo.com.au>  <20040615164848.GA8276@hobbes.itsari.int> <3473.1087374022@redhat.com>
In-Reply-To: <3473.1087374022@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
>>-		put_task_struct(tsk);
>>+		task_unlock(tsk);
> 
> 
> Ummm... that doesn't look right.
> 
> 
>>-	get_task_struct(tsk);
> 
> 
> This is necessary to stop someone deallocating the task structure, can the
> task structure be deallocated whilst locked?
> 

Ooh maybe it can. Should that be a read_lock of the tasklist lock then?
