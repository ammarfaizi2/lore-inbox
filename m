Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVFTLfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVFTLfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 07:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVFTLfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 07:35:38 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:24329 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261204AbVFTLfe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 07:35:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZplKwlGS0A4PHmogHYUqqYjVVhRRKbX9ptl7M+gHT2SlblXYyI/vojXcFkj71/UEnweB7yvYrNVF66+s8LmtW44iG+kNZS1qEa9bZ/N8a6zY1PFNdGULJrw+m+FYRygp6gwqb2oIzLg37DxsEXHg65FuG704DI39rdsOUT7qn9A=
Message-ID: <5c77e7070506200435229cd064@mail.gmail.com>
Date: Mon, 20 Jun 2005 13:35:33 +0200
From: Carsten Otte <cotte.de@gmail.com>
Reply-To: Carsten Otte <cotte.de@gmail.com>
To: Mauricio Lin <mauriciolin@gmail.com>
Subject: Re: How to identify cow (copy-on-write) pages during kernel execution?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3f250c71050620043066ff0262@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3f250c7105061922454dfe31ed@mail.gmail.com>
	 <5c77e707050620040930b4d0cf@mail.gmail.com>
	 <3f250c71050620043066ff0262@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/05, Mauricio Lin <mauriciolin@gmail.com> wrote:
> So the only way to identify copy-on-write pages is when page fault
> related to copy-on-write happens, right? I mean in the
> handle_pte_fault() that calls do_wp_page().
That shows you at the time of copy, and at a given time later you can
also walk the mm and look that the pte's to see if they are writable.
