Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288955AbSAFN4D>; Sun, 6 Jan 2002 08:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSAFNzx>; Sun, 6 Jan 2002 08:55:53 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:19683 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S288955AbSAFNzs>; Sun, 6 Jan 2002 08:55:48 -0500
Message-ID: <3C38575B.4080900@acm.org>
Date: Sun, 06 Jan 2002 14:55:39 +0100
From: Laurent Guerby <guerby@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: dewar@gnat.com
CC: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020106134353.B7091F2FF5@nile.gnat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dewar@gnat.com wrote:

> A bit heavy, but yes, that's a trick that will work.


Well, the whole point of the exercise and discussion is how to
be heavy handed with the compiler so that it can't get away with
ignoring what the programmer asks even with a good language lawyer :).

If I followed correctly, language lawyer wins in C,
but not in Ada (but the developper can loose if the Ada compiler
just says the declaration is illegal :).

But even in the case of the compiler reading more (and writing anyway),
I think it  is the compiler burden to prove that the extra stuff
"read" is not observable (in the sense of external
effect) at execution. In a memory-mapped I/O architecture
where there is a distinction on external effects between a byte read
and a word read (eg: a crash :),  the compiler can't get very far IMHO
(if it accepts the declaration of course).

-- 
Laurent Guerby <guerby@acm.org>

