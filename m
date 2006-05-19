Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWESQAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWESQAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 12:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWESQAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 12:00:13 -0400
Received: from xenotime.net ([66.160.160.81]:31673 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932416AbWESQAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 12:00:11 -0400
Date: Fri, 19 May 2006 09:02:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Scott Preece" <sepreece@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2/2] list.h doc: change "counter" to "control"
Message-Id: <20060519090236.ef9b5c81.rdunlap@xenotime.net>
In-Reply-To: <7b69d1470605190837o44f2c0f5o4aa9faa421dfb3f7@mail.gmail.com>
References: <20060518105400.2aac9f44.rdunlap@xenotime.net>
	<7b69d1470605190837o44f2c0f5o4aa9faa421dfb3f7@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2006 10:37:28 -0500 Scott Preece wrote:

> I agree that "counter" is wrong, but "control" is still a little
> vague. How about:
> "the &struct list_head that tracks iteration over the list" or
> "the &struct list_head that tracks current location in list."

I considered "iterator" (but that's the macro itself I think),
"control", "variable", "pointer", and "position".
"current location" would be OK with me.


> scott
> 
> On 5/18/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> >
> > Use loop "control" instead of loop "counter" for list iterator
> > descriptions.  They are not counters, they are controls or
> > pointers or positions.
> >
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  include/linux/list.h |   52 +++++++++++++++++++++++++--------------------------
> >  1 files changed, 26 insertions(+), 26 deletions(-)
> >
> > --- linux-2617-rc4g6.orig/include/linux/list.h
> > +++ linux-2617-rc4g6/include/linux/list.h
> > @@ -328,7 +328,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each       -       iterate over a list
> > - * @pos:       the &struct list_head to use as a loop counter.
> > + * @pos:       the &struct list_head to use as a loop control.
> >   * @head:      the head for your list.
> >   */
> >  #define list_for_each(pos, head) \
> > @@ -337,7 +337,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * __list_for_each     -       iterate over a list
> > - * @pos:       the &struct list_head to use as a loop counter.
> > + * @pos:       the &struct list_head to use as a loop control.
> >   * @head:      the head for your list.
> >   *
> >   * This variant differs from list_for_each() in that it's the
> > @@ -350,7 +350,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_prev  -       iterate over a list backwards
> > - * @pos:       the &struct list_head to use as a loop counter.
> > + * @pos:       the &struct list_head to use as a loop control.
> >   * @head:      the head for your list.
> >   */
> >  #define list_for_each_prev(pos, head) \
> > @@ -359,7 +359,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_safe - iterate over a list safe against removal of list entry
> > - * @pos:       the &struct list_head to use as a loop counter.
> > + * @pos:       the &struct list_head to use as a loop control.
> >   * @n:         another &struct list_head to use as temporary storage
> >   * @head:      the head for your list.
> >   */
> > @@ -369,7 +369,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_entry -       iterate over list of given type
> > - * @pos:       the type * to use as a loop counter.
> > + * @pos:       the type * to use as a loop control.
> >   * @head:      the head for your list.
> >   * @member:    the name of the list_struct within the struct.
> >   */
> > @@ -380,7 +380,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_entry_reverse - iterate backwards over list of given type.
> > - * @pos:       the type * to use as a loop counter.
> > + * @pos:       the type * to use as a loop control.
> >   * @head:      the head for your list.
> >   * @member:    the name of the list_struct within the struct.
> >   */
> > @@ -402,7 +402,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_entry_continue - continue iteration over list of given type
> > - * @pos:       the type * to use as a loop counter.
> > + * @pos:       the type * to use as a loop control.
> >   * @head:      the head for your list.
> >   * @member:    the name of the list_struct within the struct.
> >   *
> > @@ -416,7 +416,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_entry_from - iterate over list of given type from the current point
> > - * @pos:       the type * to use as a loop counter.
> > + * @pos:       the type * to use as a loop control.
> >   * @head:      the head for your list.
> >   * @member:    the name of the list_struct within the struct.
> >   *
> > @@ -428,7 +428,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
> > - * @pos:       the type * to use as a loop counter.
> > + * @pos:       the type * to use as a loop control.
> >   * @n:         another type * to use as temporary storage
> >   * @head:      the head for your list.
> >   * @member:    the name of the list_struct within the struct.
> > @@ -441,7 +441,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_entry_safe_continue
> > - * @pos:       the type * to use as a loop counter.
> > + * @pos:       the type * to use as a loop control.
> >   * @n:         another type * to use as temporary storage
> >   * @head:      the head for your list.
> >   * @member:    the name of the list_struct within the struct.
> > @@ -457,7 +457,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_entry_safe_from
> > - * @pos:       the type * to use as a loop counter.
> > + * @pos:       the type * to use as a loop control.
> >   * @n:         another type * to use as temporary storage
> >   * @head:      the head for your list.
> >   * @member:    the name of the list_struct within the struct.
> > @@ -472,7 +472,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_entry_safe_reverse
> > - * @pos:       the type * to use as a loop counter.
> > + * @pos:       the type * to use as a loop control.
> >   * @n:         another type * to use as temporary storage
> >   * @head:      the head for your list.
> >   * @member:    the name of the list_struct within the struct.
> > @@ -488,7 +488,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_rcu   -       iterate over an rcu-protected list
> > - * @pos:       the &struct list_head to use as a loop counter.
> > + * @pos:       the &struct list_head to use as a loop control.
> >   * @head:      the head for your list.
> >   *
> >   * This list-traversal primitive may safely run concurrently with
> > @@ -507,7 +507,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_safe_rcu
> > - * @pos:       the &struct list_head to use as a loop counter.
> > + * @pos:       the &struct list_head to use as a loop control.
> >   * @n:         another &struct list_head to use as temporary storage
> >   * @head:      the head for your list.
> >   *
> > @@ -524,7 +524,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_entry_rcu     -       iterate over rcu list of given type
> > - * @pos:       the type * to use as a loop counter.
> > + * @pos:       the type * to use as a loop control.
> >   * @head:      the head for your list.
> >   * @member:    the name of the list_struct within the struct.
> >   *
> > @@ -541,7 +541,7 @@ static inline void list_splice_init(stru
> >
> >  /**
> >   * list_for_each_continue_rcu
> > - * @pos:       the &struct list_head to use as a loop counter.
> > + * @pos:       the &struct list_head to use as a loop control.
> >   * @head:      the head for your list.
> >   *
> >   * Iterate over an rcu-protected list, continuing after current point.
> > @@ -791,8 +791,8 @@ static inline void hlist_add_after_rcu(s
> >
> >  /**
> >   * hlist_for_each_entry        - iterate over list of given type
> > - * @tpos:      the type * to use as a loop counter.
> > - * @pos:       the &struct hlist_node to use as a loop counter.
> > + * @tpos:      the type * to use as a loop control.
> > + * @pos:       the &struct hlist_node to use as a loop control.
> >   * @head:      the head for your list.
> >   * @member:    the name of the hlist_node within the struct.
> >   */
> > @@ -804,8 +804,8 @@ static inline void hlist_add_after_rcu(s
> >
> >  /**
> >   * hlist_for_each_entry_continue - iterate over a hlist continuing after current point
> > - * @tpos:      the type * to use as a loop counter.
> > - * @pos:       the &struct hlist_node to use as a loop counter.
> > + * @tpos:      the type * to use as a loop control.
> > + * @pos:       the &struct hlist_node to use as a loop control.
> >   * @member:    the name of the hlist_node within the struct.
> >   */
> >  #define hlist_for_each_entry_continue(tpos, pos, member)                \
> > @@ -816,8 +816,8 @@ static inline void hlist_add_after_rcu(s
> >
> >  /**
> >   * hlist_for_each_entry_from - iterate over a hlist continuing from current point
> > - * @tpos:      the type * to use as a loop counter.
> > - * @pos:       the &struct hlist_node to use as a loop counter.
> > + * @tpos:      the type * to use as a loop control.
> > + * @pos:       the &struct hlist_node to use as a loop control.
> >   * @member:    the name of the hlist_node within the struct.
> >   */
> >  #define hlist_for_each_entry_from(tpos, pos, member)                    \
> > @@ -827,8 +827,8 @@ static inline void hlist_add_after_rcu(s
> >
> >  /**
> >   * hlist_for_each_entry_safe - iterate over list of given type safe against removal of list entry
> > - * @tpos:      the type * to use as a loop counter.
> > - * @pos:       the &struct hlist_node to use as a loop counter.
> > + * @tpos:      the type * to use as a loop control.
> > + * @pos:       the &struct hlist_node to use as a loop control.
> >   * @n:         another &struct hlist_node to use as temporary storage
> >   * @head:      the head for your list.
> >   * @member:    the name of the hlist_node within the struct.
> > @@ -841,8 +841,8 @@ static inline void hlist_add_after_rcu(s
> >
> >  /**
> >   * hlist_for_each_entry_rcu - iterate over rcu list of given type
> > - * @tpos:      the type * to use as a loop counter.
> > - * @pos:       the &struct hlist_node to use as a loop counter.
> > + * @tpos:      the type * to use as a loop control.
> > + * @pos:       the &struct hlist_node to use as a loop control.
> >   * @head:      the head for your list.
> >   * @member:    the name of the hlist_node within the struct.
> >   *
> >
> >
> > ---
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 


---
~Randy
