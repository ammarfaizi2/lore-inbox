Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWFNA7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWFNA7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWFNA7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:59:55 -0400
Received: from relay01.pair.com ([209.68.5.15]:64784 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S932339AbWFNA7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:59:54 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
To: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [PATCH 08/11] Task watchers:  Register profile as a task watcher
Date: Tue, 13 Jun 2006 19:59:25 -0500
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       Philippe Elie <phil.el@wanadoo.fr>, oprofile-list@lists.sourceforge.net
References: <20060613235122.130021000@localhost.localdomain> <1150242897.21787.148.camel@stark>
In-Reply-To: <1150242897.21787.148.camel@stark>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131959.47635.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 18:54, Matt Helsley wrote:

>  	switch (type) {
> -		case PROFILE_TASK_EXIT:
> -			err = blocking_notifier_chain_register(
> -					&task_exit_notifier, n);
> -			break;
>  		case PROFILE_MUNMAP:
>  			err = blocking_notifier_chain_register(
>  					&munmap_notifier, n);
>  			break;
>  	}

	if (type == PROFILE_MUNMAP)

?

> @@ -140,14 +130,10 @@ int profile_event_register(enum profile_
>  int profile_event_unregister(enum profile_type type, struct notifier_block
> * n) {
>  	int err = -EINVAL;
>
>  	switch (type) {
> -		case PROFILE_TASK_EXIT:
> -			err = blocking_notifier_chain_unregister(
> -					&task_exit_notifier, n);
> -			break;
>  		case PROFILE_MUNMAP:
>  			err = blocking_notifier_chain_unregister(
>  					&munmap_notifier, n);
>  			break;
>  	}

Same...

Thanks,
Chase
