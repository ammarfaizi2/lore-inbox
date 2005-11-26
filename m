Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVKZKXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVKZKXy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 05:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVKZKXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 05:23:53 -0500
Received: from agf.customers.acn.gr ([213.5.17.156]:30904 "EHLO
	enigma.wired-net.gr") by vger.kernel.org with ESMTP
	id S1750738AbVKZKXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 05:23:53 -0500
Message-ID: <1131.62.1.12.53.1133000719.squirrel@webmail.wired-net.gr>
Date: Sat, 26 Nov 2005 12:25:19 +0200 (EET)
Subject: Ordered Sorted List
From: "Nanakos Chrysostomos" <nanakos@wired-net.gr>
To: linux-kernel@vger.kernel.org
Reply-To: nanakos@wired-net.gr
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,all.Can someone please explain this source code with an example???

***********************************************************************
#include <stdio.h>

typedef struct list_tag {
        int data;
        struct list_tag *next;
}ListNode;

typedef ListNode *slist;
slist empty = NULL;

void slistInsert(slist *sp,int t)
{
        ListNode *n=(ListNode *)malloc(sizeof(ListNode));
        if(n == NULL)
        {
                printf("Out of memory\n");
                exit(1);
        }
        n->data = t;
        while(*sp!=NULL && (*sp)->data < t)
        {
        sp = &((*sp)->next);   //Why we do this here,i miss this point
        }
        n->next = *sp;
        *sp = n;

}


void slistRemove(slist *sp,int t)
{
        ListNode *n;
        while(*sp!=NULL && (*sp)->data <t)
                sp = &((*sp)->next);
        if(*sp == NULL)
        {
                printf("Not found\n");
                exit(1);
        }

        n=*sp;
        *sp = (*sp)->next;
        free(n);
}

void slistPrint(slist s)
{
        ListNode *n;
        for(n=s;n!=NULL; n=n->next)
                printf("%d\n",n->data);
}

void main()
{

      slistInsert(&empty,4);
      slistInsert(&empty,8);

      slistInsert(&empty,24);
      slistInsert(&empty,50);
      slistInsert(&empty,20);
      slistInsert(&empty,2);
      slistRemove(&empty,4);
      slistInsert(&empty,18);
      slistPrint(empty);
}

Thank you very much in advance.

-
To unsubscribe from this list: send the line "unsubscribe
linux-c-programming" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


