Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTGBQug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTGBQug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:50:36 -0400
Received: from [65.248.4.67] ([65.248.4.67]:697 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S264052AbTGBQue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:50:34 -0400
Message-ID: <000701c340bb$e48b43e0$19dfa7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: about send task
Date: Wed, 2 Jul 2003 14:03:38 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people , i am thinking about process migration.
And the idea to transfer a simples task is:



Thread1 in NODE A    <-------TCP CONN----------->   Thread2 in NODE B
__________________
__________________

- select task by
    -verify the availability  of these virtual addresses.

if it busy , free the memory of these virtual addresses.
- get structs mm , vma , task , zone , page
  and copy all buffers existing in the

         -alloc all the buffer of task.


- send all buffers to
        -re-build structs (alloc_task_struct,page_zone,pte_page...)

                                                                            
               -INIT_LIST_HEAD()

                                                                            
               -wake_up_process()
-send all virtual addresses to thread2



Please , i´d like some comments/ideas about this.

thanks
Breno

