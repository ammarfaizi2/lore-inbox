Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbUBAMM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 07:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUBAMM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 07:12:58 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:64435 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S265277AbUBAMM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 07:12:57 -0500
Message-ID: <401CEDAD.70601@bluewin.ch>
Date: Sun, 01 Feb 2004 13:14:37 +0100
From: Julien Rebetez <julien.r@bluewin.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.22  memory overwriting 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
I've writen the following program :


#include <stdio.h>

int main ()
{
        int p[4];
        p[0]=1;
        p[1]=2;
        p[2]=3;
        p[3]=4;
        p[4]=5;

        printf ("%i, %i, %i, %i, %i\n", p[0], p[1], p[2], p[3],
p[4]);
        return 0;
}

I compile it with :

 gcc -o test test.c -Wall

and when i launch it, the output is :

 julien:$> ./test
1, 2, 3, 4, 5

Should I not get a SIGSEV from the system ? Isn't it dangerous to allow 
the user to put 5 elements in a 4 elements tab?

(tested on Linux 2.4.22 on a i686)

Thanks

