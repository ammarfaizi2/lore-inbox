Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293519AbSBZEty>; Mon, 25 Feb 2002 23:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293518AbSBZEtf>; Mon, 25 Feb 2002 23:49:35 -0500
Received: from unused-36-130.ixpres.com ([216.105.36.130]:47631 "EHLO
	ajanta.ghen.net") by vger.kernel.org with ESMTP id <S293517AbSBZEtc> convert rfc822-to-8bit;
	Mon, 25 Feb 2002 23:49:32 -0500
Message-Id: <200202260453.g1Q4rnm08770@ajanta.ghen.net>
Date: Mon, 25 Feb 2002 20:53:49 -0800
From: "Rajagopal S. Iyer" <rajsand@hindunet.com>
Subject: Scheduling algorithm  - Suggestion 
To: linux-kernel@vger.kernel.org
Cc: rajsand@rediffmail.com, lok@vsnl.com
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0
Reply-To: rajsand@hindunet.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Respected Community members,

Consider the kernel just having to do the scheduling as follows (the thought just occured.. I do not have mathematical proof): 

The suggested duration for 0-7 could be rounded off to match line frequency of the respective countries.

The suggested scheduling is sequence (In the Real time)
 0-->1-->1-->0-->0-->1-->2-->2-->1-->0-->0-->1-->2;
 1-->2-->2-->1-->1-->2-->3-->3-->2-->1-->1-->2-->3. (VM0)
  |
  v
 4
  |
  v
 0-->1-->1-->0-->0-->1-->2-->2-->1-->0-->0-->1-->2;
 1-->2-->2-->1-->1-->2-->3-->3-->2-->1-->1-->2-->3. (VM1)
  |
  v
 5
  |
  v
 6
  |
  v
 7

0. Running
 
   In this state the process is actually run
 
 1. Preparatory
 
  In this state the necessary resource allocations for running the process is prepared
 
  1. Read the Process Table
  2. allocate necessary resources
  3. signal to run the process
 
 2. Wait State
 
 This is the stage the machine execute the heartbeat function which consists of

  1. read any error status from the heartbeat messages of other nodes
  2. prepare the status report
  3. write error / log messages in the respective locations
 
 3. Review
 
    In this state, the messages after running of the process and the necessary
    steps for transmitting the messages to the next process are taken

 4. Reorder states
 In this stage, the states of the two processes are altered
     (If the state of the process 0 is 0123 then 1032
          and of the process 1 is 1032 change to 0123)
 
 5. Cycle Complete state
 
In this state the Necessary logging of Machine state and heartbeat, Cycle
No Detail Stamping is to be taken care of (Fill details here)
 

 6. State Increment State
  This is the crucial state where the promotion of state is done.
 
 7. respawn state
   process with incremented states will 0 will be 1 and so on...


VM0 and VM1 are two virtual machines tasks
 
--
This email was brought to you by Hindunet Mail
http://www.hindunet.com/freemail/

