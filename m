Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288377AbSACXXF>; Thu, 3 Jan 2002 18:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288379AbSACXW4>; Thu, 3 Jan 2002 18:22:56 -0500
Received: from jalon.able.es ([212.97.163.2]:41089 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S288380AbSACXWo>;
	Thu, 3 Jan 2002 18:22:44 -0500
Date: Fri, 4 Jan 2002 00:25:53 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Message-ID: <20020104002553.A15792@werewolf.able.es>
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com> <E16MAp4-00018b-00@starship.berlin> <20020103143630.D25846@conectiva.com.br> <E16MBIw-00018y-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E16MBIw-00018y-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Jan 03, 2002 at 18:05:19 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020103 Daniel Phillips wrote:
>> 
>> Maybe CodingStyle should have an entry for this, I'd vote for this style:
>>
>> static inline struct inode *new_inode(struct super_block *sb)
>
>OK, I'll revise it to that style.  Shall we start an official janitor's style
>guide? ;-)
>

Perhaps it is a silly question for kernel hackers, but I found it useful
for making code more readable...
Why dont you use things like:

typedef struct inode inode;
typedef struct super_block super_block;

so you can write things like

static inline inode* new_inode(super_block* cb)
{
	inode* ni;
	ni = (inode*)malloc(sizeof(inode));
	...
}

(ie, kill 'struct' visual pollution...)

??

Isn't it more readable ?

Just curious...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre1-beo #3 SMP Thu Dec 27 10:15:27 CET 2001 i686
