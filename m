Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKQIik>; Fri, 17 Nov 2000 03:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbQKQIi3>; Fri, 17 Nov 2000 03:38:29 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:26340 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129076AbQKQIiP>; Fri, 17 Nov 2000 03:38:15 -0500
From: Christoph Rohland <cr@sap.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: shm swapping in 2.4 again
In-Reply-To: <Pine.LNX.4.21.0011161929080.13085-100000@duckman.distro.conectiva>
Organisation: SAP LinuxLab
Date: 17 Nov 2000 09:08:02 +0100
In-Reply-To: Rik van Riel's message of "Thu, 16 Nov 2000 19:30:46 -0200 (BRDT)"
Message-ID: <qwwsnorxbq5.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Thu, 16 Nov 2000, Rik van Riel wrote:
> On 16 Nov 2000, Christoph Rohland wrote:
>> Also we have to make sure to derefence the swap entry if the
>> last reference is in the shm segmant table .
> 
> Why is this?

Because you never get a page fault on the shm segmants. So you never
will exchange a swap entry with a real page in these segments
automatically.

Actually I think the best approach would be to replace the entry on
the first swapin. 

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
