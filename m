Return-Path: <linux-kernel-owner+w=401wt.eu-S965108AbWLMUBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWLMUBT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWLMUBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:01:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:10607 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965088AbWLMUBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:01:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qUshkZaCOc/0OiTYWScQM5t4krVSNxQBgCY+ujfdG3wTCNzEumWJafHpNDvcPLI/RmVRwTaMEcFqDRoEcbbPgnU0SLAMIuEY5eM6mYnqsL8SukxqZ8rjbgChnv6MB67AoemAK66nluvL0EAOBthvSfSmsEUgMQjdgSL6eTzzsmY=
Message-ID: <a36005b50612131201j766d7585yad6d77629582d468@mail.gmail.com>
Date: Wed, 13 Dec 2006 12:01:14 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Teunis Peters" <teunis@wintersgift.com>
Subject: Re: Question: removal of syscall macros?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45804B99.2060008@wintersgift.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45804B99.2060008@wintersgift.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Teunis Peters <teunis@wintersgift.com> wrote:
> Now that syscall macros have been pulled from the -mm tree, what method
> is recommended to use syscalls?

glibc forever had a syscall() function for just that purpose.  It was
never a good idea to use the macros since they didn't work in PIC.
