Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131346AbRDDTvu>; Wed, 4 Apr 2001 15:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132053AbRDDTvk>; Wed, 4 Apr 2001 15:51:40 -0400
Received: from ns2.servicenet.com.ar ([200.41.148.12]:22535 "EHLO
	servnet.servicenet.com.ar") by vger.kernel.org with ESMTP
	id <S131346AbRDDTvZ>; Wed, 4 Apr 2001 15:51:25 -0400
Message-ID: <A0C675E9DC2CD411A5870040053AEBA028416D@MAINSERVER>
From: =?iso-8859-1?Q?Sarda=F1ons=2C_Eliel?= 
	<Eliel.Sardanons@philips.edu.ar>
To: linux-kernel@vger.kernel.org
Subject: kernel/sched.c questions
Date: Wed, 4 Apr 2001 16:52:32 -0300 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.0.1461.28)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I would like to know why you put this two functions:
void scheduling_functions_start_here(void) { }
...
void scheduling_functions_end_here(void) { }

why you put 'case TASK_RUNNING'

switch (prev->state) {
                case TASK_INTERRUPTIBLE:
                        if (signal_pending(prev)) {
                                prev->state = TASK_RUNNING;
                                break;
                        }
                default:
                        del_from_runqueue(prev);
                case TASK_RUNNING:
}

and the last one:

in the function schedule() you always use this syntax:

-----
if (a_condition)
    goto bebe;
bebe_back


bebe:
    do_bebe();
    goto bebe_back;
------
why not just doing:
   
   if (a_condition)
         do_bebe();


I know that goto's are better but finaly you are jumping to a function and
then calling the function. I think you can improve performance doing this.

