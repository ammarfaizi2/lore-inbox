Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWHGKpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWHGKpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 06:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWHGKpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 06:45:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:63812 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751175AbWHGKpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 06:45:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ew49NIW1f/OBcIWHTfAGVKcTF796WrQ0WqW9Ew01XaZp4ZWMPB7ezVl731A2lBN1rmEK6DoukIMiSHH/Y4qxnbyDdnEd0+iwW5UcWw0qoSt7hC97tndv2ck8moNwKqzHa47JHbUOt7dktlh/g4Djy0hprfwVUD7C6Lm1zZWsjcA=
Message-ID: <84144f020608070345q58a9c12btc2eb57cd7bf8dd14@mail.gmail.com>
Date: Mon, 7 Aug 2006 13:45:20 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
Cc: froese@gmx.de, B.Steinbrink@gmx.de, hurtta+gmane@siilo.fmi.fi,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <787b0d920607220105l21251402nc98381edbc27a0c5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607220105l21251402nc98381edbc27a0c5@mail.gmail.com>
X-Google-Sender-Auth: 961c75bc3d5e17af
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Edgar Toernig writes:
> > Urgs, so any user may remove mappings from another process and
> > let it crash?

On 7/22/06, Albert Cahalan <acahalan@gmail.com> wrote:
> Two good solutions come to mind:
>
> a. substitute the zero page
> b. make the mapping private and touch it as if C-O-W happened

Actually, I think revokeat() and frevoke() should be consistent with
mmap which will make a process go SIGBUS if it attempts to write to
truncated shared mapping.

                                          Pekka
