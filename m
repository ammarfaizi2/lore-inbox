Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132728AbRDQPdK>; Tue, 17 Apr 2001 11:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132727AbRDQPdA>; Tue, 17 Apr 2001 11:33:00 -0400
Received: from nef.ens.fr ([129.199.96.32]:50948 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S132726AbRDQPcv>;
	Tue, 17 Apr 2001 11:32:51 -0400
Date: Tue, 17 Apr 2001 17:32:46 +0200
From: =?ISO-8859-1?Q?=C9ric?= Brunet <ebrunet@quatramaran.ens.fr>
Message-Id: <200104171532.RAA12722@quatramaran.ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <200104171426.JAA76050@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200104170915.LAA00596@quatramaran.ens.fr> <200104171426.JAA76050@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ens.mailing-lists.linux-kernel, you wrote:
>
>I believe it allows the debugger to start the process to be debugged.
>
Well, the debugger simply needs to do something like

        pid_t child = fork();
        if (child == 0) {
                ptrace(PTRACE_TRACEME,0,0,0);
                execve(the_debugged_process,args,env);
        }

It is more portable, more traditionnal and works very well.

Éric Brunet
